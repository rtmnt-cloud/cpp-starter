param(
    [Parameter(Position=0, Mandatory=$true)]
    [string]$ProjectName
)

$root = $ProjectName
New-Item -ItemType Directory -Force -Path "$root/src","$root/include","$root/build" | Out-Null

$mainCpp = @"
#include <iostream>

int main() {
    std::cout << "Hello from $ProjectName!" << std::endl;
    return 0;
}
"@
Set-Content "$root/src/main.cpp" $mainCpp -Encoding UTF8

$cmake = @"
cmake_minimum_required(VERSION 3.10)
project($ProjectName)

set(CMAKE_CXX_STANDARD 17)
include_directories(include)
add_executable($ProjectName src/main.cpp)
"@
Set-Content "$root/CMakeLists.txt" $cmake -Encoding UTF8

Write-Host "Created C++ project: $ProjectName"