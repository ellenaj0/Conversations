import argparse
import json

if __name__ == '__main__':
	parser = argparse.ArgumentParser(description='Parse a JSON file and extract specific keys.')
	parser.add_argument('--file', '-f', required=True, help='Path to the JSON file to parse.')
	parser.add_argument('--sim_num', '-s', type=int)
	parser.add_argument('--players', '-p', type=int)
	args = parser.parse_args()

	with open(args.file) as f:
		data = json.load(f)

	# player_ids = set()
	# for turn in range(args.length):
	# 	turn_data = data['turn_impact'][turn]
	# 	if turn_data['speaker_name'] == 'Player2':
	# 		player_id = turn_data['speaker_id']
	# 		player_ids.add(player_id)

	# assert len(player_ids) == args.players

	shared_scores = data['score_breakdown']

	# Individual scores
	for p in range(args.players):
		curr_player_id = data['scores']['player_scores'][p]['id']

		final_score = data['scores']['player_scores'][p]['scores']

		print(f"{args.sim_num}, {p}, {final_score['total']}, {final_score['individual']}, {shared_scores['total']}, {shared_scores['importance']}, {shared_scores['coherence']}, {shared_scores['freshness']}, {shared_scores['nonmonotonousness']}")

#"score_breakdown": {
#     "total": 166.74000000000004,
#     "importance": 96.74000000000004,
#     "coherence": 67.0,
#     "freshness": 8.0,
#     "nonmonotonousness": -5.0
#   },