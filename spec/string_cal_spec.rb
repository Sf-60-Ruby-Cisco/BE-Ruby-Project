	require "string_cal"		#0

describe StringCalculator do	#0

##====================1
 describe ".add" do
   context "given an empty string" do
     it "returns zero" do
       expect(StringCalculator.add("")).to eq(0)
     end
   end
 end
##====================1

##====================2
#	describe ".add" do
#		context "given '4'" do
#			it "returns 4" do
#				expect(StringCalculator.add("4")).to eql(4)
#			end
#		end
#		
#		context "given '10'" do
#			it "returns '10'" do
#				expect(StringCalculator.add("10")).to eql(10)
#			end
#		end
#	end
##====================2

#====================3
# 	describe ".add" do
# 		context "two numbers" do
# 			context "given '2.4,4'" do
# 				it "returns 6.4" do
# 					expect(StringCalculator.add("2.4 4")).to eql(6.4)
# 				end
# 			end
			
# 			context "given '17,100'" do
# 				it "returns 117.0" do
# 					expect(StringCalculator.add("17 100")).to eql(117.0)
# 				end
# 			end
# 		end
# 	end
# #====================3

end		#0
