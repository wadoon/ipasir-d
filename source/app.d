import std.stdio;
import ipasir;
//dmd -fPIC -L-lstdc++ ipasir/sat/minisat220/libipasirminisat220.a  source/app.d source/ipasirc.d source/ipasir.d
void main()
{
	auto s = new Solver();
	writeln(s.signature());
}
