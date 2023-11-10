package themes_4.thema_4_5

// Создайте ваш первый проект, который печатает на экран фразу «Hello, Scala!». Запустите ваш код, убедитесь, что он работает.
object HelloScala {
  def main(args: Array[String]): Unit = {
    println("Hello, Scala!")
  }
}

// Напишите программу, которая выводит фразу «Hello, Scala!» справа налево.
object ReverseHelloScala {
  def main(args: Array[String]): Unit = {
    val message = "Hello, Scala!"
    val reversedMessage = message.reverse
    println(reversedMessage)
  }
}

// Напишите программу, которая переводит всю фразу в нижний регистр.
object LowercaseHelloScala {
  def main(args: Array[String]): Unit = {
    val message = "Hello, Scala!"
    val lowercaseMessage = message.toLowerCase
    println(lowercaseMessage)
  }
}

// Напишите программу, которая удаляет символ!
object RemoveCharacter {
  def main(args: Array[String]): Unit = {
    val inputString = "Hello, Scala!"
    val charToRemove = '!'
    val resultString = removeCharacter(inputString, charToRemove)
    println(resultString)
  }

  private def removeCharacter(input: String, charToRemove: Char): String = {
    val filteredString = input.filterNot(_ == charToRemove)
    filteredString
  }
}

// Напишите программу, которая добавляет в конец фразы «and goodbye python!»
object AddToTheEnd {
  def main(args: Array[String]): Unit = {
    val originalString = "Hello, Scala!"
    val phraseToAdd = "and goodbye python!"
    val resultString = addToTheEnd(originalString, phraseToAdd)
    println(resultString)
  }

  private def addToTheEnd(input: String, phraseToAdd: String): String = {
    val combinedString = input + " " + phraseToAdd
    combinedString
  }
}

/*
Напишите программу, которая вычисляет ежемесячный оклад сотрудника после вычета налогов.
На вход вашей программе подается значение годового дохода до вычета налогов,
размер премии  — в процентах от годового дохода и компенсация питания.
 */
object SalaryCalculator {
  def main(args: Array[String]): Unit = {
    val annualIncome = 60000.0 // Годовой доход до вычета налогов
    val bonusPercentage = 10 // Размер премии в процентах
    val mealCompensation = 200 // Компенсация питания в месяц

    val monthlySalary = calculateMonthlySalary(annualIncome, bonusPercentage, mealCompensation)
    println(s"Ежемесячный оклад после вычета налогов: $monthlySalary")
  }

  private def calculateMonthlySalary(annualIncome: Double, bonusPercentage: Int, mealCompensation: Double): Double = {
    val taxRate = 0.20 // Налоговая ставка 20%
    val annualIncomeAfterTax = annualIncome * (1 - taxRate)
    val bonus = annualIncome * bonusPercentage / 100.0
    val monthlyIncomeAfterTax = annualIncomeAfterTax / 12
    val monthlySalary = monthlyIncomeAfterTax + bonus + mealCompensation
    monthlySalary
  }
}

/*
Напишите программу, которая рассчитывает для каждого сотрудника отклонение (в процентах) от среднего значения оклада
на уровне всего отдела. В итоговом значении должно учитываться в большую или меньшую сторону отклонение размера оклада.
На вход вашей программе подаются все значения, аналогичные предыдущей программе,
а также список со значениями окладов сотрудников отдела 100, 150, 200, 80, 120, 75.
 */
object SalaryDeviationCalculator {
  def main(args: Array[String]): Unit = {
    val salaries = List(100.0, 150.0, 200.0, 80.0, 120.0, 75.0)
    val bonusPercentage = 10 // Размер премии в процентах
    val mealCompensation = 200 // Компенсация питания в месяц

    val departmentAverageSalary = calculateAverageSalary(salaries)
    val deviations = calculateSalaryDeviations(salaries, bonusPercentage, mealCompensation, departmentAverageSalary)

    for ((salary, deviation) <- salaries.zip(deviations)) {
      val roundedDeviation = BigDecimal(deviation).setScale(2, BigDecimal.RoundingMode.HALF_UP).toDouble
      println(s"Оклад: $salary, Отклонение: $roundedDeviation%")
    }
  }

  private def calculateAverageSalary(salaries: List[Double]): Double = {
    val totalSalary = salaries.sum
    val averageSalary = totalSalary / salaries.length
    averageSalary
  }

  private def calculateSalaryDeviations(salaries: List[Double], bonusPercentage: Int, mealCompensation: Double, departmentAverageSalary: Double): List[Double] = {
    salaries.map { salary =>
      val bonus = salary * bonusPercentage / 100.0
      val totalIncome = salary + bonus + mealCompensation
      val deviation = ((totalIncome - departmentAverageSalary) / departmentAverageSalary) * 100
      deviation
    }
  }
}

/*
Попробуйте рассчитать новую зарплату сотрудника, добавив (или отняв, если сотрудник плохо себя вел)
необходимую сумму с учетом результатов прошлого задания. Добавьте его зарплату в список
и вычислите значение самой высокой зарплаты и самой низкой.
+
Также в вашу команду пришли два специалиста с окладами 350 и 90 тысяч рублей.
Попробуйте отсортировать список сотрудников по уровню оклада от меньшего к большему.
+
Кажется, вы взяли в вашу команду еще одного сотрудника и предложили ему оклад 130 тысяч.
Вычислите самостоятельно номер сотрудника в списке так, чтобы сортировка не нарушилась, и добавьте его на это место.
+
Попробуйте вывести номера сотрудников из полученного списка, которые попадают под категорию middle.
На входе программе подается «вилка» зарплаты специалистов уровня middle.
 */
object UpdatedSalaryCalculator {
  def main(args: Array[String]): Unit = {
    val salaries = List(100.0, 150.0, 200.0, 80.0, 120.0, 75.0, 130.0) // Включая нового сотрудника с зарплатой 130.0
    val bonusPercentage = 10   // Размер премии в процентах
    val mealCompensation = 200 // Компенсация питания в месяц
    val deviations = calculateSalaryDeviations(salaries, bonusPercentage, mealCompensation, calculateAverageSalary(salaries))

    val middleSalaryMin = 100.0 // Минимальная зарплата в категории middle
    val middleSalaryMax = 150.0 // Максимальная зарплата в категории middle

    // Рассчитываем новую зарплату с учетом отклонения и добавления/вычета необходимой суммы
    val newSalaries = salaries.zip(deviations).map { case (salary, deviation) =>
      val adjustment = if (deviation >= 0) deviation * 0.01 * salary else -deviation * 0.01 * salary
      salary + adjustment
    }

    val maxSalary = newSalaries.max
    val minSalary = newSalaries.min

    println("Исходные зарплаты:")
    salaries.foreach(s => println(s))

    println("\nНовые зарплаты:")
    newSalaries.foreach(s => println(s))

    println("\nСамая высокая зарплата: " + maxSalary)
    println("Самая низкая зарплата: " + minSalary)

    val sortedSalaries = newSalaries.sorted
    println("\nСортировка по уровню оклада (по возрастанию):")
    sortedSalaries.foreach(s => println(s))

    val middleEmployees = salaries.zipWithIndex.collect {
      case (salary, index) if salary >= middleSalaryMin && salary <= middleSalaryMax => index
    }

    println("\nСотрудники, входящие в категорию 'middle':")
    middleEmployees.foreach(index => println(s"Сотрудник $index"))
  }

  private def calculateAverageSalary(salaries: List[Double]): Double = {
    val totalSalary = salaries.sum
    val averageSalary = totalSalary / salaries.length
    averageSalary
  }

  private def calculateSalaryDeviations(salaries: List[Double], bonusPercentage: Int, mealCompensation: Double, departmentAverageSalary: Double): List[Double] = {
    salaries.map { salary =>
      val bonus = salary * bonusPercentage / 100.0
      val totalIncome = salary + bonus + mealCompensation
      val deviation = ((totalIncome - departmentAverageSalary) / departmentAverageSalary) * 100
      deviation
    }
  }
}

/*
Однако наступил кризис и ваши сотрудники требуют повысить зарплату.
Вам необходимо проиндексировать зарплату каждого сотрудника на уровень инфляции  — 7 %.
 */
object UpdatedSalaryCalculator2 {
  def main(args: Array[String]): Unit = {
    val salaries = List(100.0, 150.0, 200.0, 80.0, 120.0, 75.0, 130.0) // Включая нового сотрудника с зарплатой 130.0
    val bonusPercentage = 10   // Размер премии в процентах
    val mealCompensation = 200 // Компенсация питания в месяц
    val deviations = calculateSalaryDeviations(salaries, bonusPercentage, mealCompensation, calculateAverageSalary(salaries))

    val inflationRate = 0.07 // Уровень инфляции (7%)

    val newSalaries = salaries.zip(deviations).map { case (salary, deviation) =>
      val adjustment = if (deviation >= 0) deviation * 0.01 * salary else -deviation * 0.01 * salary
      val indexedSalary = salary * (1 + inflationRate) // Повышение зарплаты на уровень инфляции
      indexedSalary + adjustment
    }

    val maxSalary = newSalaries.max
    val minSalary = newSalaries.min

    println("Исходные зарплаты:")
    salaries.foreach(s => println(s))

    println("\nНовые зарплаты после индексации на уровень инфляции:")
    newSalaries.foreach(s => println(s))

    println("\nСамая высокая зарплата: " + maxSalary)
    println("Самая низкая зарплата: " + minSalary)
  }

  private def calculateAverageSalary(salaries: List[Double]): Double = {
    val totalSalary = salaries.sum
    val averageSalary = totalSalary / salaries.length
    averageSalary
  }

  private def calculateSalaryDeviations(salaries: List[Double], bonusPercentage: Int, mealCompensation: Double, departmentAverageSalary: Double): List[Double] = {
    salaries.map { salary =>
      val bonus = salary * bonusPercentage / 100.0
      val totalIncome = salary + bonus + mealCompensation
      val deviation = ((totalIncome - departmentAverageSalary) / departmentAverageSalary) * 100
      deviation
    }
  }
}


