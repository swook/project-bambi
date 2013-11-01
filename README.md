# MATLAB HS13 – Research Plan

> * Group Name: Team Bambi
> * Group participants names: Amedeo Agosti, Marco Binelli, Prashanth Kanduri, Seonwook Park
> * Project Title: Run Bambi, run!

## General Introduction
Our aim is to simulate a forest fire situation where inhabitants or animals flee
following forest paths formed by their trails.

With this study, we can save animals which are escaping from forest fires by
predicting their path. We can also define animal protection better by evaluating
the trails used, calculated with our model.

We can apply these mechanics to other problems such as human evacuations in
urban disasters. The direct application of the model could lead to more
efficient rescue efforts in the case of fire.

Studies for human trail formation and forest fire spread are well established.
Our study aims to combine the two studies using relatable case studies.

We will focus on generating simple landscapes to apply our model to, in order to
keep discussion as general as possible. Possibly as an extension, we will apply
our model to existing landscapes.

## The Model
### Trail formation
#### Independent Variables
- Entry and exit points of forest.
- Number of agents.
- Vegetation growth rate.
- Rate of erosion by agent.
- [Extension] Mobility and level of trampling of animals.

#### Dependent Variables
- Paths formed.

### Forest fire spreading
#### Independent Variables
- Forest fire spread rate.
- [Extension] Terrain parameters such as obstacle presence, elevation, and
   ground roughness.

#### Dependent Variables
- Burnt and burning areas over time.

### Path Finding within fire
#### Independent Variables
- Agent velocity.
- [Extension] Path finding capability.

#### Dependent Variables
- Path taken in fire.
- Probability of survival.

## Fundamental Questions
- Will Bambi survive our forest fire?
- How well do living things survive forest fires and how useful are previously
  formed forest paths?

## Expected Results
- Forest paths will be very useful in quick evacuation of forest fires.

## References
- D Helbing et al. - Modelling the evolution of human trail systems (Vol. 388 1997)
- P Bak et al. - A forest-fire model and some thoughts on turbulence (Physics Letters A. 1990)
- Camazin - Trail formation in ants (2001)

## Research Methods
### Trail Formation
- Active Walker Model

### Forest Fire Spread
- Agent-Based Model
