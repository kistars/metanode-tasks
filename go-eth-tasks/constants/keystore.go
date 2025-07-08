package constants

import (
	"fmt"
	"log"
	"os"

	"github.com/ethereum/go-ethereum/accounts/keystore"
)

func ImportKs() {
	file := "/home/tomj/geth-tutorial/keystore/UTC--2025-07-08T13-20-37.967619404Z--74edf70e292ba5b835faf90a164e02357a92fc89"
	ks := keystore.NewKeyStore("/home/tomj/geth-tutorial/keystore/", keystore.StandardScryptN, keystore.StandardScryptP)

	jsonBytes, err := os.ReadFile(file)
	if err != nil {
		log.Fatal(err)
	}

	password := "012345"
	account, err := ks.Import(jsonBytes, password, password)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("account address =", account.Address.Hex())
}
