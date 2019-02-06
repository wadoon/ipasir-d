import std.conv;
import ipasirc;

alias Literal = int;
alias Clause = Literal[];

class Solver {
    private void* internalSolver;
    private Literal maximum;

    this() {
        this.internalSolver = ipasir_init();
    }

    ~this() {
        ipasir_release(internalSolver);
    }

    string signature() {
        return to!string(ipasir_signature());
    }

    void add(in Clause clause){
        if(clause.length>0) {
            foreach(lit; clause)
                ipasir_add(this.internalSolver, lit);
            ipasir_add(this.internalSolver, 0);
        }
    }

    void assume(in Literal lit) {
        void ipasir_assume (void * solver, int lit);
    }


    void assume(in Clause clause) {
        void ipasir_assume (void * solver, int lit);
    }


    int solve(){
        return ipasir_solve(this.internalSolver);
    }


    int get_value(Literal l){
        return ipasir_val(this.internalSolver, l);
    }

    int[] model(){
        int[] model;
        for(int i = 1; i <= maximum; i++ ){
            model ~= get_value(i);
        }
        return model;
    }

    void set_terminate(S=void)(S* state, int function(void* state) terminate) {
        ipasir_set_terminate(this.internalSolver, state, terminate);
    }

    void set_learn(S=void)(S* state, int max_length, void function(S* state, int* clause) callback){
        ipasir_set_learn (this.internalSolver, cast(void*) state, max_length, callback);
    }
    
}