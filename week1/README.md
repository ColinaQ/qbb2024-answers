# Exercise 1
# Step 1.1

# (1000000 * 3) / 100 = 30000
# 30000 100bp reads are needed to sequence a 1Mbp genome to 3x coverage.

# Step 1.4

# 1. In my simulation, about 49906 positions have not been sequenced.
# 2. The Poisson model predicts that there are 49787 positions and the normal distribution predicts that there are 41632 positions.
# It seems that the Poisson distribution fits the data more, and the value of position very close to the actual value. The normal distribution predicts a close value as well, but not as close as the former.

# Step 1.5
# 1. In my simulation, about 92 positions have not been sequenced.
# 2. The Poisson model predicts that there are 45 positions and the normal distribution predicts that there are 783 positions.
# Again, it seems that the Poisson distribution fits the data more. The value from the Poisson model is very close to the actual value, while the normal distribution predicts a very off number.

# Step 1.6
# 1. In my simulation, about 5 positions have not been sequenced.
# 2. The Poisson model predicts that there are 9.36e-08 positions and the normal distribution predicts that there are 0.0216 positions.
# Lastly, it seems that neither Poisson nor normal distributions gives a very accurate value. 

# Step 2.4
# dot -Tpng step_2_3.dot -o ex2_digraph.png

# Step 2.5
# One possible genome sequence that would produce these reads could be: "TTGATTCATTTCTCTTA".

# Step 2.6
# In order to accurately reconstruct the sequence of the genome, the sequencing depth needs to be deep enough and the coverage needs to be broad enough to be comprehensively representative. Longer read lengths would help reduce confusion and ambiguity caused by repetitive regions. High-quality sequencers would help minimize errors during sequencing, and quality control softwares would help identify the issues produced during this process. Lastly, the computational approach taken to analyze the data is also very important.