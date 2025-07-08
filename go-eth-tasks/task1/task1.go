package task1

import (
	"context"
	"fmt"
	"log"
	"math/big"

	"github.com/ethereum/go-ethereum/common"
	"github.com/ethereum/go-ethereum/core/types"
	"github.com/ethereum/go-ethereum/crypto"
	"github.com/ethereum/go-ethereum/ethclient"
	"github.com/kistars/metanode-tasks/go-eth-tasks/constants"
)

func ExecTask1() {
	// 生成客户端
	client, err := ethclient.Dial(constants.SepoliaAddr)
	if err != nil {
		log.Fatal(err)
	}

	// 根据区块hash和number查询区块信息
	blockHash := common.HexToHash("0xd8fc7c3ed21db964e603b358140692149f94f1b632353d854f4870093df7f8d9")
	block, err := client.BlockByHash(context.Background(), blockHash)
	if err != nil {
		log.Fatal(err)
	}

	fmt.Println("Block hash =", block.Hash().Hex())
	fmt.Println("Block timestamp =", block.Time())
	fmt.Println("Block header timestamp =", block.Header().Time)
	fmt.Println("Block number of transactions =", len(block.Transactions()))

	// 发送交易
	privateKey, err := crypto.HexToECDSA(constants.SenderPrivateKey)
	if err != nil {
		log.Fatal(err)
	}

	fromAddress := crypto.PubkeyToAddress(privateKey.PublicKey)

	// 获取随机数nonce
	nonce, err := client.PendingNonceAt(context.Background(), fromAddress)
	if err != nil {
		log.Fatal(err)
	}

	// 获取gas单价
	gasPrice, err := client.SuggestGasPrice(context.Background())
	if err != nil {
		log.Fatal(err)
	}
	gasLimit := uint64(21000) // in units

	// 发送数量
	amount := big.NewInt(1000000000000000) // in wei (0.001 eth), 1e18

	// 接收方地址
	toAddress := common.HexToAddress(constants.ReceiverAddr)
	tx := types.NewTransaction(nonce, toAddress, amount, gasLimit, gasPrice, []byte{})

	// chainID
	chainID, err := client.ChainID(context.Background())
	if err != nil {
		log.Fatal(err)
	}

	// sign
	signedTx, err := types.SignTx(tx, types.NewEIP155Signer(chainID), privateKey)
	if err != nil {
		log.Fatal(err)
	}

	// 发送transaction
	err = client.SendTransaction(context.Background(), signedTx)
	if err != nil {
		log.Fatal(err)
	}

	// 打印交易哈希值
	fmt.Println("transaction hash =", signedTx.Hash().Hex())
}
