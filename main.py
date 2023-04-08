import matplotlib.pyplot as plt
import numpy as np

# Data from Eros

E = 0.2227818894620597
A = 1.458129136101339
B = A * np.sqrt(1-(E*E))

I = 10.82782330218545

theta_data = np.arange(0, np.pi * 2, 0.1)
sine_data = B*np.sin(theta_data)
cosine_data = A*np.cos(theta_data)
z_data = np.sin(I) * np.cos(theta_data)


fig = plt.figure()
ax = fig.add_subplot(projection='3d')
ax.plot(0, 0, 0, color="yellow")
ax.scatter(A*E, 0, 0, color = 'orange', s = 400)
ax.scatter(cosine_data, sine_data, z_data)
plt.show()
