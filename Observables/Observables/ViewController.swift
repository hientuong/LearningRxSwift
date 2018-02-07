//
//  ViewController.swift
//  Observables
//
//  Created by Hien Tuong on 2/7/18.
//  Copyright © 2018 Hien Tuong. All rights reserved.
//

import UIKit
import RxSwift

func example(of description: String, action: () -> Void) {
    print("\n--- Example of:", description, "---")
    action() }

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        example(of: "just, of, from") {
//            let one = 1
//            let two = 2
//            let three = 3
//
//            let observable: Observable<Int> = Observable<Int>.just(one)
//            let observable2 = Observable.of(one, two, three)
//            let observable3 = Observable.of([one, two, three])
//            let observable4 = Observable.from([one, two, three])
//
//            // TO DO: Subscribe
//            observable4.subscribe{ event in
//                print(event)
//            }
//        }
        
//        example(of: "range") {
//            let observable = Observable<Int>.range(start: 10, count: 5)
//
//            observable.subscribe{
//                print($0)
//            }
//        }
        
//        example(of: "dispose") {
//            let observable = Observable.of("A", "B", "C")
//
//            let subscription = observable.subscribe{
//                print($0)
//            }
//
//            subscription.dispose()
//        }
        
//        example(of: "DisposeBag") {
//            let disposeBag = DisposeBag()
//
//            Observable.of("A", "B", "C")
//                .subscribe{
//                    print($0)
//            }.disposed(by: disposeBag)
//        }
        
//        example(of: "create") {
//            let disposeBag = DisposeBag()
//
//            Observable<String>.create({ (observer) -> Disposable in
//
//                observer.onNext("1")
//
//                observer.onCompleted()
//
//                observer.onNext("?")
//
//                return Disposables.create()
//            })
//            .subscribe(
//                onNext: {print($0)},
//                onError: {print($0)},
//                onCompleted: {print("Complete")},
//                onDisposed: {print("Disposed")}).disposed(by: disposeBag)
//        }
        
//        example(of: "deferred") {
//            let disposeBag = DisposeBag()
//
//            var flip = false
//
//            var factory: Observable<Int> = Observable.deferred{
//                flip = !flip
//
//                if flip {
//                    return Observable.of(1, 2, 3)
//                } else {
//                    return Observable.of(4, 5, 6)
//                }
//            }
//
//            for _ in 0...3 {
//                factory.subscribe( onNext: {
//                    print($0, terminator: "")
//                })
//                .disposed(by: disposeBag)
//                print()
//            }
//        }
        
        // challenge
//        example(of: "never") {
//            let disposeBag = DisposeBag()
//            
//            var flip = false
//            
//            let observer = Observable<Any>.never()
//            
//            observer
//            .subscribe(onNext: { element in
//                print(element)
//            }, onCompleted: {
//                print("Completed")
//            }, onDisposed: {
//                flip = !flip
//                print(flip)
//                print("Disposed")
//            }).disposed(by: disposeBag)
//            
//        }
    }
    

    
    

}

