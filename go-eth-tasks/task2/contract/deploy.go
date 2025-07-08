package contract

import (
	"context"
	"fmt"
	"log"
	"math/big"

	"github.com/ethereum/go-ethereum/accounts/abi/bind"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/kistars/metanode-tasks/go-eth-tasks/constants"
)

func DeployMyContract() {
	client, err := ethclient.Dial(constants.SepoliaAddr)
	if err != nil {
		log.Fatal(err)
	}

	// 生成私钥公钥
	privateKey, err := crypto.HexToECDSA(constants.SenderPrivateKey)
	if err != nil {
		log.Fatal(err)
	}
	fromAddress := crypto.PubkeyToAddress(privateKey.PublicKey)

	// 生成下一个交易的nonce
	nonce, err := client.PendingNonceAt(context.Background(), fromAddress)
	if err != nil {
		log.Fatal(err)
	}
	// gas费用
	gasPrice, err := client.SuggestGasPrice(context.Background())
	if err != nil {
		log.Fatal(err)
	}

	opts, err := bind.NewKeyedTransactorWithChainID(privateKey, big.NewInt(11155111))
	if err != nil {
		log.Fatal(err)
	}
	opts.GasPrice = gasPrice
	opts.GasLimit = uint64(300000)
	opts.Nonce = big.NewInt(int64(nonce))
	opts.Value = big.NewInt(0)

	// 部署合约
	address, tx, contract, err := DeployContract(opts, client)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("deployed successfully")
	fmt.Println("contract address =", address.Hex())
	fmt.Println("transcation hash =", tx.Hash().Hex())

	_ = contract
}
