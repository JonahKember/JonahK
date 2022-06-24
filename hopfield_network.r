##################
# Hopfield Network
##################

# Multimodal information from widespread neocortical areas converges in the hippocampus. 

# The ability of hippocampal networks to output this information when provided with similar information at a later time (referred to
# as 'auto-association', or 'pattern completion'), is supported by recurrent connectivity in the hippocampal subfield CA3.

# A Hopfield network is a simple example of an auto-associative network with similar properties- one that relies on biologically 
# realistic, Hebbian learning rules.

# Here, I provide R code capable of implementing a Hopfield network. Enjoy!


# Define Functions
##################

learn <- function(hf, states){
 
    # Learn the weights of a Hopfield network from a set of input states using Hebbian learning.
    #   For a given input state v, set the weights of the network hf[i,j] equal to (2*v[i] - 1) * (2*v[j] - 1). 
    #   No self connections (hf[i,i] = 0).
    #   Estimate the matrix hf[i,j] for each state individually, then sum together (hf = hf_v1 + hf_v2 + hf_v3...).

    n_nodes = dim(states)[1]
    n_states = dim(states)[2]

    for (s in 1:n_states){

        st = states[,s]
        w_st = matrix(0,n_nodes,n_nodes)

            for (i in 1:n_nodes){
                for (j in 1:n_nodes){
                    w_st[i,j] = (2*st[i] - 1)*(2*st[j] - 1)
                }
            }

        hf = hf + w_st
    }
    diag(hf) = 0
    return(hf)
}


activate <- function(hf,state){

    # Determine the activation dynamics of the network. 
    #    If the net input to the node is >= .5, the node activates (1).
    #    If the net input to the node is < .5, the node does not activate (0).

    for (i in 1:n_nodes){
            w = 0
            for (j in 1:n_nodes){
                w = w + (hf[i,j] * state[j])
            }

            if (w >= 0.5){state[i] = 1}
            if (w < 0){state[i] = 0}
        }
    return(state)
}


recall <- function(hf, new_state){

    # 'Recall' a stored state from a new, unobserved state. 
    #    Run activation dynamics for all nodes; reiterate until convergence (local energy minimum).

    n_nodes = dim(hf)[1]
    old = new_state
    new = activate(hf,new_state)
    n_runs = 0

    while(sum(old == new) != n_nodes) {
        old = new    
        new = activate(hf,new)
        n_runs = n_runs + 1
    }
    cat('   Convergence reached following',n_runs,'iterations')
    return(new)
}

compare <- function(updated_state, states){

    # Compare the 'recalled' state to the stored states.

    match_check = matrix(0,n_states)
    
    for (i in 1:n_states){
        match_check[i] = sum(states[,i] == updated_state)
    }

    if(max(match_check) == n_nodes){match_n = which(match_check == n_nodes)}
    if(min(match_check) == 0){
        match_n = which(match_check == 0)
        updated_state = as.integer(-updated_state > -.5)
    }
    
    cat('\n\n     New state has been recalled as state', match_n,'.\n\n')
    return(updated_state) 
}



# Hopfield Pipeline
###################

# Define parameters.
n_states = 3
n_nodes = 100

# Generate state matrix (states = column vectors).
states = matrix(0, n_nodes, n_states)

for (i in 1:n_states){
    states[,i] = sample(c(0,1), replace = TRUE, size = n_nodes)
}

# Initialize Hopfield network.
hf = matrix(0, n_nodes, n_nodes)

# Learn weights.
hf = learn(hf,states)

# Define new 'test' state.
new_state = sample(c(0,1), replace = TRUE, size = n_nodes)

# Recall/Pattern-completion.
updated_state = recall(hf, new_state)

# Compare recalled state to previously learned states.
updated_state = compare(updated_state, states)


