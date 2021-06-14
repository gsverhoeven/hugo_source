--- 
title: Cooperatives and payment schemes
author: Gertjan Verhoeven
date: '2020-09-03'
draft: TRUE
---

# Summary

We review the book by Bogetoft and Olesen on Cooperatives and payment schemes.
We investigate the potential for using its material to explore the ability of reinforcement learning to solve games. The idea is to start with games that can be easily solved using standard game theoretic analysis, and then add complexity that makes them hard to solve using the standard techniques.

# Game theory vs Reinforcement learning

If we take a simple game such as the Prisoners dilemma, we see that we have two players, that have access to the same action sets (confess or not confess), and perform their action simultaneously. 

Each players outcome (the Reward) depends on the action of the other player.

If they both remain silent, i.e. do not confess, they both get -1. However, if one of them cooperates and confesses, and the other remains silent, the prisoner that confesses gets 0, and the one remaining silent gets -10. If both of them confess, they both get a penalty of -5. 

The games is played only once: so it does not make sense to "act nice" for future reward. Now we look for a strategy that is a Nash equilibrium. This means that no player wants to change its action, given the other players action. If both remain silent, then a player is better of to switch to confess. If both confess, then no player is better of remain silent. So both confessing is the Nash equilibrium for this game. We can also call this the rational or optimal solution of the game. 

If we translate this to a reinforcement learning setting, we end up in what is called a Multi Agent Reinforcement learning (MARL) setting.
We immediately spot a difference with GT: in RL, players play the game repeatedly. So could it be possible to reach the optimal solution of both remaining silent? And: does this difference mean that we cannot use MARL to solve one shot static games? And: if so, is this a problem? The real life systems we wish to model are typically dynamic (i.e. repeat) games as well.
