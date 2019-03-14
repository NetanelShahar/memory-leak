output: MemoryLeakTest.o
	g++ MemoryLeakTest.o -o output


MemoryLeakTest.o: MemoryLeakTest.cpp
	g++ -c MemoryLeakTest.cpp
