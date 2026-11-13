import foundation
// utility functions
//average of numbers
func calculateMean(of numbers:[Double]) ->
Double{
  if numbers.isEmpty{
    return0.0
  }
  let sum = numbers.reduce(0,+)
  return sum/Double(numbers.count)
}
//largest no. in an array
func findMaximum(in numbers: [Int]) -> Int?{
  return numbers.Max()
