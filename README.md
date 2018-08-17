# nerve-fiber-modeling

Scripts to model the interactions in a mammalian nerve fiber. There at two separate models presented here. 

## Biophysics based mechanistic model
	-- Constructed in NEURON computing environment
	-- Based on,

	1. Wesselink, W. A., J. Holsheimer, and H. B. K. Boom. "A model of the electrical behaviour of myelinated sensory nerve fibres based on human data." Medical & biological engineering & computing 37.2 (1999): 228-235.

	2. Schwarz, Jürgen R., Gordon Reid, and Hugh Bostock. "Action potentials and membrane currents in the human node of Ranvier." Pflügers Archiv 430.2 (1995): 283-292.

	-- To simulate,
	1. Run the NEURON code on a cluster, ../_mechanistic/_neuron/mytest.sh
	2. Analyse the stored data from neuron simulations using the matlab codes under,
	../_mechanistic/_matlab/findRel.m
	
## Timing based functional model
	-- Constructed on MATLAB
	-- To simulate,
	Run ../_functional/Reduced_master.m


## Sample data to reproduce figures
	-- Sample data and codes to reproduce results from our manuscript are provided in,
	../sample/ folder