export CORE_ROOT=/home/ubunto/rv32i_pipelined

all: icarus

icarus: icarus_compile
	vvp $(CORE_ROOT)/temp/top.out

icarus_compile:
	mkdir -p temp
	iverilog -f flist -o $(CORE_ROOT)/temp/top.out

clean:
	rm -rf temp