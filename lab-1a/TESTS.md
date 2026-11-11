the 8 test cases are-

Test Case 1: Student passed with good marks
input:let name = "aman"
let rollno = 34
let attendance = 75
var marks = [78,85,92,65,88]
output: Student:aman|total:408/500|percentage:81.60%
passed:yes 
Math with bonus:83.0

Test case 2: Attendance below 75%
input:let name = "rahul"
let rollno = 56
let attendance = 70
var marks = [78,85,92,65,88]
output: Student:rahul|total:408/500|percentage:81.6%
passed:no 
Math with bonus:83.0

Test Case 3: One subject below passing marks
input:let name = "priya"
let rollno = 46
let attendance = 75
var marks = [78,85,92,35,88]
output: Student:priya|total:378/500|percentage:75.6%
passed:no 
Math with bonus:83.0

Test Case 4: Minimum passing marks in all subjects
output:let name = "neha"
let rollno = 34
let attendance = 75
var marks = [40,40,40,40,40]
output: Students:neha|total:200/500|percentage:40.0%
passed:yes 
Math with bonus:45.0

Test Case 5: Maximum marks in all subject
input:let name = "priya"
let roll = 24
let Attendance = 85
var marks = [100,100,100,100,100]
output: Student:priya|total:500/500|percentage:100.0%
passes:yes 
Math with bonus:105.0

Test Case 6: Zero marks in all subjects
input:let name = "neha"
let rollno = 34
let attendance = 75
var marks = [0,0,0,0,0]
output: Student:neha|total:0/500|percentage:0.0%
passed:no 
Math with bonus:5.0

Test case 7: Mathematics marks below 40 but bonus added
input:let name = "karan"
let rollno = 45
let attendance = 80
var marks = {35,85,92,65,88]
output: Student:karan|total:365/500|percentage:73.0%
passed:no 
Math with bonus:40.0

Test Case 8: Excellent marks but zero attendance
input:let name = "aman"
let rollno = 34
let attendance = 0
var marks = [90,90,90,90,90]
output: Student:aman|total:450/500|percentage:90.0%
passed:no 
Math with bonus:95.0


