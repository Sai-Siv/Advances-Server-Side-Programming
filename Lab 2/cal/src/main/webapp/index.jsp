<!-- calculator.html -->
<!DOCTYPE html>
<html>
<head>
    <title>Simple Calculator</title>
</head>
<body>
    <form action="CalculatorServlet" method="post">
        <input type="number" name="num1" placeholder="Enter number 1" required><br><br>
        <input type="number" name="num2" placeholder="Enter number 2" required><br><br>
        <select name="operation">
            <option value="add">Addition</option>
            <option value="subtract">Subtraction</option>
            <option value="multiply">Multiplication</option>
            <option value="divide">Division</option>
        </select><br><br>
        <button type="submit">Calculate</button>
    </form>
</body>
</html>
