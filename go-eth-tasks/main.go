package main

import (
	"log"

	"github.com/kistars/metanode-tasks/go-eth-tasks/task2"
)

func main() {
	// 设置log flags，添加Lshortfile或Llongfile
	log.SetFlags(log.LstdFlags | log.Lshortfile)
	task2.ExecTask2()
}
