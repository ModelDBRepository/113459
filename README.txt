The following m files are included:

discrimination_MLE.m
    Calculates the discrimination ability of a given population of neurons.
    This program may take an hour to run
categorization_llikhd.m
    Calculates the identification ability of a given population of neurons.
    This program may take 4 minutes to run.

    Both scripts above use the following helper functions:
        MNRRS.m
            Gets the response of the population of neurons to a specific frequency.
        likhood.m
            The likelihood function (equation 2 in manuscript)
        get_params.m
            The parameters used for the simulation (population parameters and testing parameters)
            Editing this file will suffice to change population or testing parameters
        smth_gass_distr.m
            Helper function for get_params to redefine over-representation.

    categorization_llikhd also includes:
        binornd_sim.m
            The Bernoulli random process simulation (Eq 5 in paper)


In addition, the following mat files are included:

discr_temp.mat
	output expected at line 93 of discrimination_MLE
	to plot, use lines 98-103

ident_temp.mat             
	output expected at line 68 of categorization_llikhd
	to plot, use lines 73-78
