# BoostDraft coding assignment, Xiang-Guan Deng

## Approach
The XML language mandates the definition of start angle brackets ("<...>") and end angle brackets ("</...>"). To manage these brackets effectively, I implemented a recursive method to handle the control flow, which navigates between the start angle brackets and the end angle brackets. Every time the program encounters an end angle bracket, it should examine the content enclosed by the preceding start angle brackets. This examination process resembles that of a stack, thus prompting me to utilize a stack data structure to manage it. If all brackets match, the method returns true.
  
## Complexity
n: string length
m: contents(or key) in XML
### Time complexity
*O(n)*, check every character to determine whether it is a valid XML format string or not.
### Space complexity
*O(m)*, the count of contents in XML string.

## How to build ?
```bash
cmake -S . -B build -G"Ninja"
ninja -C build clean
ninja -C build
```

## How to test ? (Only support on Linux platform)
I write a script to test *DetermineXml* function in Linux script file.  
Tester can perform *python genPattern.py* to generate test command which can execute in runtest.sh  
```bash
./runtest.sh
```




