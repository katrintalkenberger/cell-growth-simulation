import imageio.v2 as iio
import os


def create_simulation_gif(source_folder, output_path, duration_s=0.1):
    # Check if results/ folder is empty

    if not os.path.exists(source_folder):
        print(f"Fehler: Der Ordner '{source_folder}' existiert nicht.")
        return

    # Get all *.png files in results/ folder
    images = [f for f in os.listdir(source_folder) if f.endswith('.png')]
    if not images:
        # Cancel script if no images are available
        print(f"Cancellation: No *.png images in '{source_folder}' found.")
        print("Run simulation.m (src folder) first.")
        return

    frames = []
    for filename in images:
        path = os.path.join(source_folder, filename)

        img = iio.imread(path)
        # Sicherstellen, dass das Bild 2D (Graustufen) oder 3D (RGB/RGBA) ist
        if img.ndim == 2 or (img.ndim == 3 and img.shape[2] in [3, 4]):
            frames.append(img)
        else:
            print(f"Überspringe ungültiges Format: {filename} mit Shape {img.shape}")

    iio.mimsave(output_path, frames, duration=duration_s, loop=0)
    print(f"Erfolg! GIF gespeichert unter: {output_path}")


if __name__ == "__main__":
    # Simulation images are stored in folder: cell-growth-simulation\results\
    simulation_results_folder = os.path.join(os.getcwd(), 'results')
    # Simulation gif folder: cell-growth-simulation\simulation_cell_growth.gif
    gif_output_file = os.path.join(os.getcwd(), 'simulation_cell_growth.gif')

    # Call main routine
    create_simulation_gif(
        source_folder=simulation_results_folder,
        output_path=gif_output_file,
        duration_s=0.1 # duration in seconds per frame (duration of 0.1 seconds corresponds to 10 FPS)
    )
