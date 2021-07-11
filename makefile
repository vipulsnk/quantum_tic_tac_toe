dev:
	# @echo "Changing Conda Env. to Quantum..."
	# source ~/anaconda3/etc/profile.d/conda.sh && conda activate quantum
	# conda activate quantum
	@echo "Starting server..."
	nodemon --exec "python " ./server.py 

create_envf:
	conda env export --no-builds > environment.yml

pip_inst:
	pip install -r ./requirements.txt

