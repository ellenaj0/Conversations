# Input arguments
length=$1
subjects=$2
memory_size=$3
players_num=$4
sim_num=$5
tmp_json_file=$6
csv_file=$7

echo "sim_num,player,player_total,player_individual,total_shared, total_importance, total_coherence, total_freshness, total_nonmonotonousness" > $csv_file
for ((i=1; i<=sim_num; i++)); do
    echo "Simulation $i"
    # Run simulation
    touch $tmp_json_file
    uv run python main.py --player p2 5 --length $length --subjects $subjects --memory_size $memory_size  --seed $((i*6)) > $tmp_json_file

    # Delete first two line
    sed -i '' '1,2d' $tmp_json_file

    # Process JSON
    python players/player_2/process_json.py --file $tmp_json_file --sim_num $i --players $players_num >> $csv_file
done

# bash players/player_2/run_simulation.sh 200 5 20 5 10 tmp.json results_mem_not_enough.csv
# bash players/player_2/run_simulation.sh 200 5 40 5 10 tmp.json results_mem_just_enough.csv
# bash players/player_2/run_simulation.sh 200 5 60 5 10 tmp.json results_mem_more_than_enough.csv

# bash players/player_2/run_simulation.sh 200 5 20 5 10 tmp.json players/player_2/results_mem_not_enough.csv 
# bash players/player_2/run_simulation.sh 200 5 40 5 10 tmp.json players/player_2/results_mem_just_enough.csv
# bash players/player_2/run_simulation.sh 200 5 60 5 10 tmp.json players/player_2/results_mem_more_than_enough.csv
