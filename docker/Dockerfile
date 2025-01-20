# Step 1: Use the specified base image
FROM nvcr.io/nvidia/pytorch:24.07-py3

# Step 2: Set the working directory to the current directory inside the container
WORKDIR /workspace

# Step 3: Copy the contents of the current directory into the container
COPY . .

# Step 4: Upgrade pip and install Python dependencies
RUN pip install --upgrade pip
RUN bash setup/create_env.sh

# Step 6: Specify the default command
CMD ["bash"]
