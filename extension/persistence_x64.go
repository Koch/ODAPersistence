package main

/*
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
*/
import "C"

import (
	"fmt"
	"io/ioutil"
	"net/http"
	"strings"
	"unsafe"
)

//export RVExtensionVersion
func RVExtensionVersion(output *C.char, outputsize C.size_t) {
	result := C.CString("Version 1.0")
	defer C.free(unsafe.Pointer(result))
	var size = C.strlen(result) + 1
	if size > outputsize {
		size = outputsize
	}
	C.memmove(unsafe.Pointer(output), unsafe.Pointer(result), size)
}

//export RVExtensionArgs
func RVExtensionArgs(output *C.char, outputsize C.size_t, input *C.char, argv **C.char, argc C.int) {
	var offset = unsafe.Sizeof(uintptr(0))
	var out []string
	for index := C.int(0); index < argc; index++ {
		out = append(out, C.GoString(*argv))
		argv = (**C.char)(unsafe.Pointer(uintptr(unsafe.Pointer(argv)) + offset))
	}
	temp := fmt.Sprintf("Function: %s nb params: %d params: %s!", C.GoString(input), argc, out)

	// Return a result to Arma
	result := C.CString(temp)
	defer C.free(unsafe.Pointer(result))
	var size = C.strlen(result) + 1
	if size > outputsize {
		size = outputsize
	}
	C.memmove(unsafe.Pointer(output), unsafe.Pointer(result), size)
}

//export RVExtension
func RVExtension(output *C.char, outputsize C.size_t, input *C.char) {
	var extensionResult strings.Builder
	var request *http.Request
	var resp *http.Response
	var isRequest bool
	var err error
	fromArma := C.GoString(input)

	client := http.Client{}

	dataFromArma := strings.Split(fromArma, "|")

	isRequest = true

	switch command := dataFromArma[0]; command {
	case "version":
		extensionResult.WriteString("1.0.0")
		isRequest = false
	case "loadPlayer":
		request, err = http.NewRequest("GET", fmt.Sprintf("http://localhost:3000/prep/%s", dataFromArma[1]), strings.NewReader(fromArma))
		if err != nil {
			extensionResult.WriteString(err.Error())
		}
		// _actualStringToSend = ["storeInfantry", _type, _name, _playerPos, _playerDir, _loadout, _inVehicle, _alive, _selectedWeapon, _playerVariables] joinString "|";
	case "get":
		request, err = http.NewRequest("GET", fmt.Sprintf("http://localhost:3000/get/%s", dataFromArma[1]), strings.NewReader(fromArma))
		if err != nil {
			extensionResult.WriteString(err.Error())
		}
	case "storeInfantry":
		request, err = http.NewRequest("GET", fmt.Sprintf("http://localhost:3000/save"), strings.NewReader(fromArma))
		if err != nil {
			extensionResult.WriteString(err.Error())
		}
	}

	if isRequest {
		resp, err = client.Do(request)
		if err != nil {
			extensionResult.WriteString(err.Error())
		}
		defer resp.Body.Close()

		if resp.StatusCode == http.StatusOK {
			bodyBytes, _ := ioutil.ReadAll(resp.Body)
			bodyString := string(bodyBytes)

			extensionResult.WriteString(bodyString)
		}
	}

	// Return a result to Arma
	result := C.CString(extensionResult.String())
	defer C.free(unsafe.Pointer(result))
	var size = C.strlen(result) + 1
	if size > outputsize {
		size = outputsize
	}
	C.memmove(unsafe.Pointer(output), unsafe.Pointer(result), size)
}

func main() {}
