#include <iostream>
#include <fstream>
#include <string>
#include <algorithm>
#include <unordered_map>
#include <vector>
#include <cassert>
#include <cwctype>
int main(int argc, char **argv) {
	std::locale::global(std::locale(getenv("LANG")));
	std::wifstream ifs(argv[1]);
	std::unordered_map<std::wstring, std::vector<std::wstring>> anagram;
	std::wstring line, sorted;
	assert(ifs.good());
	while (!std::getline(ifs, line).eof()) {
		std::transform(line.begin(), line.end(), line.begin(), std::towlower);
		sorted = line;
		std::sort(sorted.begin(), sorted.end());
		std::pair<std::unordered_map<std::wstring, std::vector<std::wstring>>::iterator,bool> p
				= anagram.emplace(sorted, std::vector<std::wstring>(std::vector<std::wstring>()));
		p.first->second.emplace_back(line);
	}
	for (auto &it : anagram) {
		if (it.second.size() > 1) {
			for (auto &a : it.second)
				std::wcout << a << " ";
			std::wcout << "\n";
		}
	}
	return 0;
}
