//
//  ModelingViewController.swift
//  technotest
//
//  Created by macbook Denis on 5/9/23.
//

import UIKit

class ModelingViewController: UIViewController {
    
    // Dependecies
    private let output: ModelingViewOutput
    private let size: Int
    private let factor: Int
    private let period: Int
    private var person: [Person]
    private var numberOfAlivePeople: Int

    
    // Properties
    var selectedIndexPaths: [IndexPath] = []
    private var grid: [[Person]] = [[]]
    private var numberOfInfectedPeople: Int = 0
    
    // UI
    private lazy var numberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        return label
    }()
    private lazy var layout: UICollectionViewFlowLayout = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        return layout
    }()
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.delegate = self
        return scrollView
    }()
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .white
        collectionView.register(
            ModelingCollectionViewCell.self,
            forCellWithReuseIdentifier: ModelingCollectionViewCell.reuseIdentifier
        )
        collectionView.alwaysBounceVertical = true
        collectionView.alwaysBounceHorizontal = true
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    // MARK: Init
    init(output: ModelingViewOutput, size: Int, factor: Int, period: Int) {
        self.output = output
        self.size = size
        self.factor = factor
        self.period = period
        self.person = Array(repeating: Person(name: "person", image: "good", isInfected: false), count: self.size)
        self.numberOfAlivePeople = size
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        configureUI()
    }
    
    // MARK: Private
    private func configureUI() {
        view.addSubview(scrollView)
        
        let totalItemCount = person.count
        let itemsPerRow = Int(sqrt(Double(totalItemCount)))
        let screenWidth = UIScreen.main.bounds.width
        let cellWidth = (screenWidth - layout.minimumInteritemSpacing) / CGFloat(itemsPerRow)
        
        self.grid = person.chunked(into: itemsPerRow)
        layout.itemSize = CGSize(width: cellWidth, height: cellWidth)
            
        
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        scrollView.addSubview(numberLabel)
        NSLayoutConstraint.activate([
            numberLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            numberLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            numberLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
        ])

        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipeGesture(_:)))
        swipeGestureRecognizer.direction = [.left, .right, .up, .down]
        collectionView.addGestureRecognizer(swipeGestureRecognizer)
        swipeGestureRecognizer.cancelsTouchesInView = false
        
        let zoomScrollView = UIScrollView()
        zoomScrollView.translatesAutoresizingMaskIntoConstraints = false
        zoomScrollView.delegate = self
        zoomScrollView.maximumZoomScale = 6.0
        scrollView.addSubview(zoomScrollView)

        NSLayoutConstraint.activate([
            zoomScrollView.topAnchor.constraint(equalTo: numberLabel.bottomAnchor, constant: 10),
            zoomScrollView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 10),
            zoomScrollView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -10),
            zoomScrollView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -10),
            zoomScrollView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -20),
            zoomScrollView.heightAnchor.constraint(equalToConstant: CGFloat(size / itemsPerRow) * (layout.itemSize.height + layout.minimumLineSpacing) + layout.sectionInset.top + layout.sectionInset.bottom + 20),
        ])

        zoomScrollView.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: zoomScrollView.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: zoomScrollView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: zoomScrollView.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: zoomScrollView.bottomAnchor),
            collectionView.centerXAnchor.constraint(equalTo: zoomScrollView.centerXAnchor),
            collectionView.centerYAnchor.constraint(equalTo: zoomScrollView.centerYAnchor),
        ])
    }

    private func updateNumberLabel() {
        numberLabel.text = "Not infected: \(numberOfAlivePeople), Infected: \(numberOfInfectedPeople)"
    }
    
    @objc private func handleSwipeGesture(_ sender: UISwipeGestureRecognizer) {
        selectedIndexPaths.removeAll()
        
        for section in 0..<collectionView.numberOfSections {
            for item in 0..<collectionView.numberOfItems(inSection: section) {
                let indexPath = IndexPath(item: item, section: section)
                selectedIndexPaths.append(indexPath)
            }
        }
        collectionView.reloadData()
    }

}

extension ModelingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return grid[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ModelingCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as! ModelingCollectionViewCell
        let person = grid[indexPath.section][indexPath.row]
        cell.configure(indexPath: indexPath, person: person)
        
        return cell
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        grid.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedIndexPaths.contains(indexPath) {
             if let index = selectedIndexPaths.firstIndex(of: indexPath) {
                 selectedIndexPaths.remove(at: index)
             }
             collectionView.deselectItem(at: indexPath, animated: true)
         } else {
             selectedIndexPaths.append(indexPath)
             collectionView.selectItem(at: indexPath, animated: true, scrollPosition: [])
         }
        
        let rowCount = grid.count
        let colCount = grid[indexPath.section].count
        let factor = self.factor
        let period = Double(self.period)
        
        var infectedCount = 0
        var infectedNeighbors: [(Int, Int)] = []
        
        for rowOffset in -1...1 {
            for colOffset in -1...1 {
                let neighborRow = indexPath.section + rowOffset
                let neighborCol = indexPath.row + colOffset
                
                if rowOffset == 0 && colOffset == 0 {
                    continue
                }
                
                if neighborRow < 0 || neighborRow >= rowCount {
                    continue
                }
                
                if neighborCol < 0 || neighborCol >= colCount {
                    continue
                }
                
                if !grid[neighborRow][neighborCol].isInfected && infectedCount < factor {
                    grid[neighborRow][neighborCol].isInfected = true
                    grid[neighborRow][neighborCol].image = "poisoned"
                    infectedCount += 1
                    infectedNeighbors.append((neighborRow, neighborCol))
                }
            }
        }
        
        if !grid[indexPath.section][indexPath.row].isInfected {
            grid[indexPath.section][indexPath.row].isInfected = true
            grid[indexPath.section][indexPath.row].image = "poisoned"
            infectedCount += 1
            numberOfInfectedPeople += 1
            numberOfAlivePeople -= 1
            updateNumberLabel()
        }
        
        collectionView.reloadItems(at: [indexPath])
        
        DispatchQueue.main.asyncAfter(deadline: .now() + period) {
            for neighbor in infectedNeighbors {
                self.grid[neighbor.0][neighbor.1].isInfected = true
                self.grid[neighbor.0][neighbor.1].image = "poisoned"
                self.numberOfInfectedPeople += 1
                self.numberOfAlivePeople -= 1
                self.updateNumberLabel()
                collectionView.reloadItems(at: [IndexPath(row: neighbor.1, section: neighbor.0)])
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, canMoveItemAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension ModelingViewController: ModelingViewInput {
    
}

extension ModelingViewController: UIScrollViewDelegate {
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return collectionView
    }
}

extension Array {
    func chunked(into size: Int) -> [[Element]] {
        return stride(from: 0, to: count, by: size).map {
            Array(self[$0 ..< Swift.min($0 + size, count)])
        }
    }
}

