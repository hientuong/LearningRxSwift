import UIKit
import RxSwift
import RxCocoa

/*
 • PublishSubject: Starts empty and only emits new elements to subscribers.
 • BehaviorSubject: Starts with an initial value and replays it or the latest element to new subscribers.
 • ReplaySubject: Initialized with a buffer size and will maintain a buffer of elements up to that size and replay it to new subscribers.
 • Variable: Wraps a BehaviorSubject, preserves its current value as state, and replays only the latest/initial value to new subscribers.
 */

example(of: "PublishSubject") {
    let subject = PublishSubject<String>()
    
    subject.onNext("Is anyone listening")
    
    let subscription_one = subject.subscribe(onNext: { string in
        print(string)
    })
    
    subject.onNext("1")
    
    let subscription_two = subject.subscribe {
        print("2)", $0.element ?? $0)
    }
    
    subject.onNext("3")
    subscription_one.dispose()
    subject.onNext("4")
    
    subject.onCompleted()
    
    subject.onNext("5")
    
    subscription_two.dispose()
    
    let bag = DisposeBag()
    
    subject
        .subscribe {
            print("3)", $0)
        }
        .disposed(by: bag)
    
    subject.onNext("?")
}

enum MyError: Error {
    case anError
}

func print<T: CustomStringConvertible>(label: String, event: Event<T>) {
    print(label, (event.element ?? event.error ?? event) ?? "N/A")
}

/*
 BehaviorSubject hoạt động tương tự như PublishSubject,
 nhưng chỉ khác ở chỗ BehaviorSubject khởi đầu với một giá trị và replay lại giá trị đó
 hoặc .next event cuối cùng của observable cho một Subscriber mới.
 */

example(of: "BehaviorSubject") {
    let subject = BehaviorSubject(value: "initial value")
    
    let bag = DisposeBag()
    
    subject.onNext("X")
    
    subject.subscribe {
        print(label: "1)", event: $0)
        }
        .disposed(by: bag)
    
    subject.onError(MyError.anError)
    
    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: bag)
}

/*
 Được khởi tạo với một kích thước bộ đệm và sẽ chứa số lượng các emit gần nhất bằng với kích thước bộ đệm đã khai báo.
 ReplaySubject sẽ replay lại tất cả các emit trong bộ đệm cho subscriber ngay khi subscriber đăng ký.
 */

example(of: "ReplaySubject") {
    let subject = ReplaySubject<String>.create(bufferSize: 2)
    
    let bag = DisposeBag()
    
    subject.onNext("1")
    subject.onNext("2")
    subject.onNext("3")
    
    subject
        .subscribe {
            print(label: "1)", event: $0)
        }
        .disposed(by: bag)
    
    subject
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: bag)
    
    subject.onNext("4")
    
    subject.onError(MyError.anError)
    subject.dispose()
    
    subject
        .subscribe{
            print(label: "3)", event: $0)
        }
        .disposed(by: bag)
}

/*
 Lưu trữ dữ liệu hiện tại của BehaviorSubject như một state
 và replay duy nhất giá trị khởi tạo hoặc giá trị cuối cùng của dữ liệu cho subscriber mới.
 */

example(of: "Variable") {
    let variable = BehaviorRelay(value: "Initial value")
    let bag = DisposeBag()
    
    variable.accept("New initial value")
    
    variable.asObservable()
        .subscribe {
            print(label: "1)", event: $0)
        }.disposed(by: bag)
    
    variable.accept("1")
    
    variable.asObservable()
        .subscribe {
            print(label: "2)", event: $0)
        }
        .disposed(by: bag)
    
    variable.accept("2")
}
