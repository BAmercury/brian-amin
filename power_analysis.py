import numpy as np

import scipy.stats

from matplotlib import pyplot as plt

# start at 10 participants
n_per_group = 10

# effect size = 0.8
group_means = [0.0, 0.8]
group_sigmas = [1.0, 1.0]

n_groups = len(group_means)

# number of simulations
n_sims = 10

# power level that we would like to reach
desired_power = 0.8

# initialise the power for the current sample size to a small value
current_power = 0.0


# List to save data
samples_save = []
powers_save = []
# keep iterating until desired power is obtained
while current_power < desired_power:

    data = np.empty([n_sims, n_per_group, n_groups])
    data.fill(np.nan)

    for i_group in range(n_groups):

        data[:, :, i_group] = np.random.normal(
            loc=group_means[i_group],
            scale=group_sigmas[i_group],
            size=[n_sims, n_per_group]
        )

    result = scipy.stats.ttest_ind(
        data[:, :, 0],
        data[:, :, 1],
        axis=1
    )

    sim_p = result[1]

    # number of simulations where the null was rejected
    n_rej = np.sum(sim_p < 0.05)

    prop_rej = n_rej / float(n_sims)

    current_power = prop_rej

    print "With {n:d} samples per group, power = {p:.3f}".format(
        n=n_per_group,
        p=current_power
    )

    samples_save.append(n_per_group)
    powers_save.append(current_power)

    # increase the number of samples by one for the next iteration of the loop
    n_per_group += 1


data_save = np.column_stack((samples_save,powers_save))

print(data_save[:,0])

np.savetxt("data0.txt",data_save[:,0])
np.savetxt("data.txt",data_save[:,1])

