Low Level API's:

				Most scenario we should use Spark's Structured API's. When a scenario specifically requires then use Low-Level API's.

Low-Level API's:
				
				1. Resilient Distributed Dataset (Manipulating Distributed Data)
				2. SparkContext
				3. Distributed Shared Variables: Accumulator's and Broadcost Variables. (Distributing and Manipulating distributed shared variables)

When to use the Low-Level API's?

				1. When a functionality cannot be executed by Structured API's Scenario
				2. Maintaining legacy codebase written using RDD's scenario
				3. Custom Shared Variable Manipulation.
				
How to Use Low Level API's?

	SparkContext is the entry point for Low-Level API's. Aces it through the sparkSession, which is the tool used to perform computation across a Spark Cluster.
	Spark.sparkContext