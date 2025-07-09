#include <atomic>
std::atomic<int> x;
std::atomic<short> y;
std::atomic<char> z;
int main() {
  ++z;
  ++y;
  ++x;
  return 0;
}