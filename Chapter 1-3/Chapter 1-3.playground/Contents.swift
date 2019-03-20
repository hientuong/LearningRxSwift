import UIKit
import RxSwift
import RxCocoa

// MARK: - Chapter 1 - Hello swift + Observables

example(of: "creating observable") {
    let one = 1
    let two = 2
    let three = 3
    
    let observable: Observable<Int> = Observable.just(one)
    
    let observable1 = Observable.of(one, two, three)
    let observable2 = Observable.of([one, two, three])
    let observable3 = Observable.from([one, two, three])
    
}

example(of: "subscribe") {
    let one = 1
    let two = 2
    let three = 3
    
    let observable = Observable.of(one, two, three)
    
    observable.subscribe(onNext: { (element) in
        print(element)
    })
}

example(of: "empty") {
    let observable = Observable<Void>.empty()
    
    observable.subscribe(onNext: {
        print($0)
    }, onCompleted: {
        print("Completed")
    })
}

example(of: "Never") {
    let observable = Observable<Void>.never()
    
    observable
        .subscribe(onNext: { element in
            print(element)
        }, onCompleted: {
            print("Completed")
        })
}

example(of: "range") {
    let observable = Observable<Int>.range(start: 1, count: 10)
    
    observable
        .subscribe(onNext: { i in
            let n = Double(i)
            let fibonacci = Int(((pow(1.61803, n) - pow(0.61803, n)) /
                2.23606).rounded())
            print(fibonacci)
        })
}

example(of: "Dispose") {
    let observable = Observable.of("A", "B", "C")
    
    let subscription = observable.subscribe {
        print($0)
    }
    subscription.dispose()
}

example(of: "Disposebag") {
    let bag = DisposeBag()
    
    Observable.of("A", "B", "C")
        .subscribe {
            print($0)
        }
        .disposed(by: bag)
}

enum MyError: Error {
    case anError
}

example(of: "create") {
    let bag = DisposeBag()
    
    Observable<String>.create({ (observer) -> Disposable in
        observer.onNext("1")
        observer.onError(MyError.anError)
        //        observer.onCompleted()
        observer.onNext("?")
        
        return Disposables.create()
    })
        .subscribe(onNext: {
            print($0)
        }, onError: {
            print($0)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Disposeed")
        })
        .disposed(by: bag)
}

example(of: "deffered") {
    let bag = DisposeBag()
    
    var flip = false
    
    let factory: Observable<String> = Observable.deferred({ () -> Observable<String> in
        flip = !flip
        
        if flip {
            return Observable.of("1", "2", "3")
        } else {
            return Observable.of("4", "5", "6")
        }
    })
    
    for _ in 0...3 {
        factory
            .subscribe(onNext: {
                print($0, terminator: "")
            })
        .disposed(by: bag)
        
        print()
    }
}

// MARK: - Challenge 1: Perform side effects -

example(of: "Never") {
    let bag = DisposeBag()
    let observable = Observable<Void>.never()
    
    observable
        .debug("debug Identifier", trimOutput: true)
        .do(onNext: { (element) in
            print(element)
        }, onSubscribe: {
            print("subscribe")
        }, onSubscribed: {
            print("Subscribed")
        }, onDispose: {
            print("Dispose")
        })
    
    observable
        .subscribe(onNext: { (element) in
            print(element)
        }, onCompleted: {
            print("Completed")
        }, onDisposed: {
            print("Dispose!!!")
        })
    .disposed(by: bag)
}
