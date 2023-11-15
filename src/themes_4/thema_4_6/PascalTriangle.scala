package themes_4.thema_4_6

import scala.annotation.tailrec


object PascalTriangle {
  def main(args: Array[String]): Unit = {

    // Функция для генерации треугольника Паскаля
    def generatePascalTriangle(level: Int): List[List[Int]] = {
      // Вспомогательная функция для генерации строки треугольника
      @tailrec
      def generateRow(rowNum: Int, prevRow: List[Int]): List[Int] = {
        if (rowNum == level) prevRow // Базовый случай: достигнут заданный уровень
        else {
          val newRow = ((1 +: prevRow.zip(prevRow.tail).map { case (a, b) => a + b }) :+ 1).reverse
          generateRow(rowNum + 1, newRow)
        }
      }

      // Начинаем с первой строки
      generateRow(0, List(1))
        // Генерируем оставшиеся строки
        .foldLeft(List(List(1)))((triangle, _) => triangle :+ generateRow(triangle.length, triangle.last))
    }

    // Функция для вывода треугольника Паскаля в удобном формате
    def printPascalTriangle(triangle: List[List[Int]]): String = {
      triangle.map(row => row.mkString(" ")).mkString("\n")
    }

    // Функция для получения значения элемента треугольника Паскаля по его координатам
    def getPascalElement(row: Int, col: Int): Int = {
      if (col == 0 || col == row) 1 // Элемент на краю треугольника
      else getPascalElement(row - 1, col - 1) + getPascalElement(row - 1, col)
    }

    // Функция для нахождения суммы элементов в указанной строке треугольника Паскаля
    def sumOfRow(row: Int): Int = {
      generatePascalTriangle(row + 1).last.sum
    }

    // Функция для проверки симметричности треугольника Паскаля
    def isSymmetric(triangle: List[List[Int]]): Boolean = {
      triangle == triangle.map(_.reverse)
    }


    val level = 5
    val pascalTriangle = generatePascalTriangle(level)

    println("Сгенерированный треугольник Паскаля:")
    // Теперь вызываем метод и выводим результат
    println(printPascalTriangle(pascalTriangle))

    val row = 3
    val col = 2
    val element = getPascalElement(row, col)
    println(s"\nЭлемент на позиции ($row, $col): $element")

    val rowSum = sumOfRow(2)
    println(s"\nСумма элементов в строке $row: $rowSum")

    val symmetric = isSymmetric(pascalTriangle)
    println(s"\nТреугольник симметричен: $symmetric")
  }
}