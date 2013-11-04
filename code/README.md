	G(r): Comfort of walking (in our case, rectangle of constant values)
	V(r): Trail potential
		> inv. proportional to treeness
		>      proportional to pathness
		> inv. proportional to probability of burning
	R(r): Position of Agents
	F(r): Amount of burning

# Trail Formation (First step)
## Input
-	G(r)

## Output
-	V(r)
-	R(r)

# Forest Fire (Second step)
## Input
-	V(r)

## Output
-	V(r)
-	F(r)

# Path finding (Second step)
## Input
-	V(r)
-	F(r)
-	R(r)

## Output
-	R(r)
