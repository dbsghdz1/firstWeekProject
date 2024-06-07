/**
    # 계산기 프로젝트
 ~~~
 
    -Parameters:
 
     -operation: 계산방식
     -firstNum: 계산에 사용되는 첫번째 숫자
     -secondNum: 계산에 사용되는 두번째 숫자

    -Function:
 
     -operate(): 계산
     -setStrategy(): 계산 방식결정
     -changeToString(): 타입을 String으로 변경, 필요없는 소수점 제거
 
    -Lv3: 단일책임원칙:
        객체는 한가지의 책임만 가져야하는 solid기법중 s에 해당한다. 단일책임원칙을 적용하기 전에는
        한 클래스안에 모든 연산자기능을 수행하게 만들었는데 단일책임원칙을 적용한 후 에는 각각의 연산자
        클래스안에서 한가지 연산자 기능만 수행하게 만들었다
        느낀점: 만약 한가지의 기능을 수정 해야하는 경우 전체가 아닌 하나의 클래스만 수정을 하게되어서 효율적이다.
 
    -Lv4: 추상화작업:
        모든 연산자 클래스들이 연산을 하는 기능이 있어 protocol을 생성하였다 그 후 복잡함이 줄어들었다
        전략패턴구현 튜터님의 조언으로 전략패턴을 구현해보았는데 전보다 책임이 명확하게 분리되어 보기 쉽게 되었다.
 
     ~~~
 */
class Calculater {
    var operation: Strategy?
    var firstNum: Double
    var secondNum: Double
    init(_ firstNum: Double, _ secondNum: Double) {
        self.firstNum = firstNum
        self.secondNum = secondNum
    }

    func operate() {
        print(self.operation?.operate(firstNum: firstNum, SecondNum: secondNum) ?? "입력형식이 잘못되었습니다.")
    }
    
    func setStrategy(strategy: Strategy) {
        self.operation = strategy
    }

}

//튜터님 조언에 따라 전략 패턴구현!
protocol Strategy {
    func operate(firstNum: Double, SecondNum: Double) -> String
}
/**
 class Strategy {
     func operate(firstNumber: Double, SecondNumber: Double) -> Double {
         return firstNumber + SecondNumber
     }
 }
 class 상속처리시 아래 클래스안에 있는 메서드들은 모두 override처리!
 */
class AddOperation: Strategy {
    func operate(firstNum: Double, SecondNum: Double) -> String {
        let strSum = String(firstNum + SecondNum)
        return changeToString(strSum)
    }
}

class SubstractOperation: Strategy {
    func operate(firstNum: Double, SecondNum: Double) -> String {
        let strSum = String(firstNum - SecondNum)
        return changeToString(strSum)
    }
}

class MultiplyOperation: Strategy {
    func operate(firstNum: Double, SecondNum: Double) -> String {
        let strSum = String(firstNum * SecondNum)
        return changeToString(strSum)
    }
}

class DivideOperation: Strategy {
    func operate(firstNum: Double, SecondNum: Double) -> String {
        let strSum = String(firstNum / SecondNum)
        return changeToString(strSum)
    }
}

class NamergeOperation: Strategy {
    func operate(firstNum: Double, SecondNum: Double) -> String {
        let strSum = String(firstNum.truncatingRemainder(dividingBy: SecondNum))
        return changeToString(strSum)
    }
}

// 만약 숫자가 정수라면 소수점을 지워주는 함수입니다.
func changeToString(_ resultArr: String) -> String {
    var arr = resultArr
    for i in arr.reversed() {
        if (i == ".") {
            arr.removeLast()
            break;
        } else if (i == "0") {
            arr.removeLast()
        } else {
            break
        }
    }
    return String(arr)
}

//test case
//let calculator1 = Calculater(2, 3) // 목표 출력값: 5
//calculator1.setStrategy(strategy: AddOperation())
//calculator1.operate()
//
//let calculator2 = Calculater(2.0, 3.0) // 목표 출력값: 5
//calculator2.setStrategy(strategy: AddOperation())
//calculator2.operate()
//
//let calculator3 = Calculater(2.0, 3.0) // 목표 출력값: -1
//calculator3.setStrategy(strategy: SubstractOperation())
//calculator3.operate()
//
//let calculator4 = Calculater(2.5, 3) // 목표 출력값: 7.5
//calculator4.setStrategy(strategy: MultiplyOperation())
//calculator4.operate()
//
//let calculator5 = Calculater(2, 3) // 목표 출력값: 2
//calculator5.setStrategy(strategy: NamergeOperation())
//calculator5.operate()
//
//let calculator6 = Calculater(2, 3) // 목표 출력값: 0.666666666666
//calculator6.setStrategy(strategy: DivideOperation())
//calculator6.operate()


