
import time

def bind_serial():
    """Generate a new Serial number for bind
    """
    now = int(time.strftime('%Y%m%d%H%M%S')) % 2**32
    return {'bind_serial': str(now)}

if __name__ == "__main__":
    print bind_serial()
