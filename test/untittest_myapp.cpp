#include "gtest/gtest.h"
#include "util/util.cpp"

TEST(TestUtilParseString, classicalString) {
    std::string input = "Un,dos,tres";
    int length_input = input.length();
    
    ASSERT_EQ(length_input, my_function(input));
}

int main(int argc, char **argv) {
    ::testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
