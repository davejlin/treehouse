package main 

import "fmt"

type Monitor struct {
	Resolution string
	Connector string
	Value float64
}

func main() {
	monitor := Monitor{}
	showFields(monitor)

	monitor = Monitor{"1080p", "HDMI", 249.99}
	showFields(monitor)

	monitor = Monitor{Value: 249.99, Connector: "HDMI"}
	showFields(monitor)
}

func showFields(m Monitor) {
	fmt.Println("Resolution: ", m.Resolution, "Connector: ", m.Connector, "Value: ", m.Value)
}

