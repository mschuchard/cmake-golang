package main

import ("fmt")

func main() {
  // address size
  if golangDefault := true; golangDefault {
    fmt.Println("INFO:sizeof_dptr[8]")
  } else {
    fmt.Println("INFO:sizeof_dptr[4]")
  }

  // application binary interface
  if golangDefault := true; golangDefault {
    fmt.Println("INFO:abi[DWARF]")
  } else {
    fmt.Println("INFO:abi[ELF]")
  }

  fmt.Println("ABI Detection")

  return
}
