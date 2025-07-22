Top Competitors

Output: hacker_id, name

Condition1: hackers who acheived full scores in more than 1 challanges
Condition2: order o/p by no of challanges where full score achieved desc, hackerId asc

tables:
1. hackers: hacker_id,name
2. difficulty: difficulty_level, score
3. challenges: challanage_id, hacker_id, difficulty_level
4. submissions: submissions_id, hacker_id, challange_id, score
