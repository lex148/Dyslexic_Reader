package main

import "fmt"
import "os"
import "os/exec"
import "time"
import "github.com/gvalkov/golang-evdev"


func main() {

  var events []evdev.InputEvent
  devs,_ := evdev.ListInputDevices("/dev/input/by-id/*Keyboard*")
  first := devs[0]
  dev ,err := evdev.Open(first)

  if(err != nil){
    fmt.Println("************************")
    fmt.Println(err)
    fmt.Println("************************")
    os.Exit(1)
  }


  fmt.Printf("Listening for Crtl-z ...\n")
  ctrl := false
  z := false

  for {
    events, err = dev.Read()
    for i := range events {
      if( events[i].Value == 0x0 && events[i].Code == 29){ ctrl = false } //ctrl up
      if( events[i].Value == 0x1 && events[i].Code == 29){ ctrl = true } //ctrl down
      if( events[i].Value == 0x1 && events[i].Code == 44){ z = true  }
    }
    if( ctrl && z ){ readit() }
    z = false
    time.Sleep(500)
  }

}


var vlc (exec.Cmd)

func readit( ){

  if( vlc.Process != nil ){
    vlc.Process.Kill()
    vlc.Process.Wait()
  }

  xsel := exec.Command("xsel")
  festival := exec.Command("text2wave","-o", "/dev/stdout","/dev/stdin" )
  vlc = *exec.Command("cvlc","stream:///dev/stdin","vlc://quit" )

  xsel_pipe,_ := xsel.StdoutPipe()
  festival.Stdin = xsel_pipe
  festival_pipe,_ := festival.StdoutPipe()
  vlc.Stdin = festival_pipe

  xsel.Start()
  festival.Start()
  vlc.Start()

}


