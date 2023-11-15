package themes_4.thema_4_6

object PascalTriangle {

  // 1. Генерация треугольника Паскаля до заданного уровня
  private def generatePascalTriangle(levels: Int): List[List[Int]] = {
    // Вспомогательная функция для вычисления значения элемента в треугольнике
    def calculatePascalValue(row: Int, col: Int): Int =
      if (col == 0 || col == row) 1
      else calculatePascalValue(row - 1, col - 1) + calculatePascalValue(row - 1, col)

    // Создание списка списков для представления треугольника Паскаля
    (0 until levels).map { row =>
      (0 to row).map(col => calculatePascalValue(row, col)).toList
    }.toList
  }

  // 2. Вывод содержимого треугольника Паскаля
  private def printPascalTriangle(triangle: List[List[Int]]): Unit = {
    triangle.foreach(row => println(row.mkString(" ")))
  }

  // 3. Получение значения элемента по номеру строки и номеру элемента
  private def getPascalElementValue(row: Int, col: Int): Int =
    if (col == 0 || col == row) 1
    else getPascalElementValue(row - 1, col - 1) + getPascalElementValue(row - 1, col)

  // 4. Сумма элементов в указанной строке треугольника Паскаля
  private def sumOfRowElements(row: Int): Int =
    (0 to row).map(col => getPascalElementValue(row, col)).sum

  // 5. Проверка симметричности треугольника Паскаля
  private def isPascalTriangleSymmetric(triangle: List[List[Int]]): Boolean = {
    triangle.forall(row => row == row.reverse)
  }

  def main(args: Array[String]): Unit = {
    // Пример использования функций
    val levels = 5
    val pascalTriangle = generatePascalTriangle(levels)

    println("Треугольник Паскаля:")
    printPascalTriangle(pascalTriangle)

    val row = 3
    val col = 2
    println(s"Значение элемента на строке $row и позиции $col: ${getPascalElementValue(row, col)}")

    val sumRow = 2
    println(s"Сумма элементов на строке $sumRow: ${sumOfRowElements(sumRow)}")

    println(s"Треугольник Паскаля симметричен: ${isPascalTriangleSymmetric(pascalTriangle)}")
  }
}
