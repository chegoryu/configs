#include <stdio.h>
#include <stdlib.h>

#include <assert.h>
#include <math.h>
#include <string.h>
#include <time.h>

#include <iostream>
#include <iomanip>

#include <algorithm>
#include <chrono>
#include <complex>
#include <random>

#include <array>
#include <bitset>
#include <deque>
#include <map>
#include <queue>
#include <set>
#include <stack>
#include <string>
#include <unordered_map>
#include <unordered_set>
#include <vector>

// #pragma comment(linker, "/STACK:256000000")

using namespace std;

using ll = long long int;
using ull = unsigned long long int;
using ld = long double;

#ifdef CHEGORYU
mt19937_64 rng(227);
#else
mt19937_64 rng(chrono::steady_clock::now().time_since_epoch().count());
#endif

ll my_rand(ll n) {
	return (ull)rng() % n;
}

[[maybe_unused]] const int INF = 1000 * 1000 * 1000 + 21;
[[maybe_unused]] const ll LLINF = (1ll << 60) + 5;
[[maybe_unused]] const int MOD = 1000 * 1000 * 1000 + 7;


int main() {
#ifdef CHEGORYU
    freopen("input.txt", "r", stdin);
    // freopen("output.txt", "w", stdout);
#else
    // freopen("", "r", stdin);
    // freopen("", "w", stdout);
#endif


    {{_cursor_}}

    return 0;
}
