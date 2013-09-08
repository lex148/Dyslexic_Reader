package main

import (
  "fmt"
  "os/exec"
	"github.com/BurntSushi/xgbutil"
	"github.com/BurntSushi/xgbutil/keybind"
	"github.com/BurntSushi/xgbutil/xevent"
)


func main() {

  X, _ := xgbutil.NewConn()
	keybind.Initialize(X)
	cb1 := keybind.KeyPressFun(
		func(X *xgbutil.XUtil, e xevent.KeyPressEvent) {
      readit()
		})
	cb1.Connect(X, X.RootWin(), "control-z", true)

  fmt.Printf("Listening for Crtl-z ...\n")
	xevent.Main(X)

}


var player (exec.Cmd)

func readit( ){

  if( player.Process != nil ){
    player.Process.Kill()
    player.Process.Wait()
  }

  xsel := exec.Command("xsel")
  festival := exec.Command("text2wave","-o", "/dev/stdout","/dev/stdin" )
  player = *exec.Command("aplay","/dev/stdin" )

  xsel_pipe,_ := xsel.StdoutPipe()
  festival.Stdin = xsel_pipe
  festival_pipe,_ := festival.StdoutPipe()
  player.Stdin = festival_pipe

  xsel.Start()
  festival.Start()
  player.Start()

}


