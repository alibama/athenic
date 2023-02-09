import streamlit as st
from ipfshttpclient import Client

# Create an IPFS client object
ipfs_client = Client()

def main():
    st.title("Store Text on IPFS")
    
    # Get user input
    user_input = st.text_input("Enter the text you want to store:")
    
    if user_input:
        # Store the user input in IPFS
        response = ipfs_client.add_str(user_input)
        ipfs_hash = response['Hash']

        # Display the IPFS hash of the stored data
        st.write("The IPFS hash of the stored data is:", ipfs_hash)
        
if __name__ == '__main__':
    main()
