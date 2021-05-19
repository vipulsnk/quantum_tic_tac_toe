dev:
	# @echo "Changing Conda Env. to Quantum..."
	# conda activate quantum
	@echo "Starting server..."
	nodemon --exec "python " ./server.py 
