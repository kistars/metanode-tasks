package contract

import (
	"context"
	"fmt"
	"log"

	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/kistars/metanode-tasks/go-eth-tasks/constants"
)

func ExecMyContract() {
	client, err := ethclient.Dial(constants.SepoliaAddr)
	if err != nil {
		log.Fatal(err)
	}

	// 生成私钥公钥
	// privateKey, err := crypto.HexToECDSA(constants.SenderPrivateKey)
	// if err != nil {
	// 	log.Fatal(err)
	// }

	// 加载合约
	myContract, err := NewContract(common.HexToAddress(constants.ContractAddress), client)
	if err != nil {
		log.Fatal(err)
	}

	// opts, err := bind.NewKeyedTransactorWithChainID(privateKey, big.NewInt(11155111))
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// 调用合约方法
	// tx, err := myContract.SetCount(opts, big.NewInt(10))
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Println("tx1 hash:", tx.Hash().Hex())

	// val = 10
	callOpts := &bind.CallOpts{Context: context.Background()}
	val1, err := myContract.GetCount(callOpts)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("val1 =", val1)

	// val = 5 + 1 = 6
	// tx, err = myContract.Increment(opts)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Println("tx2 hash:", tx.Hash().Hex())
	// val2, err := myContract.GetCount(callOpts)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Println("val2 = ", val2)

	// // val = 6 - 1 = 5
	// tx, err = myContract.Decrement(opts)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Println("tx3 hash:", tx.Hash().Hex())
	// val3, err := myContract.GetCount(callOpts)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	// fmt.Println("val3 = ", val3)
}
