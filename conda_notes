# Conda notes
## Installing miniconda
* Go to [miniconda](https://conda.io/miniconda.html) download page and get ready to download the installer of your choice/system.

  * For miniconda 2 on linux

`wget https://repo.continuum.io/miniconda/Miniconda2-latest-Linux-x86_64.sh`

  * For miniconda 3 on linux **(we will install this one, miniconda 3)**

`wget https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh`

  * (on a Mac you might use)

`curl -O https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh`

 * execute the installer (And be ready to interact with it a little bit)

```
chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh
```

It will run for a bit, then ask you to scroll through the license and confirm installation details. Then it will run for a bit more. When it is complete, it instructs us to exit our terminal and launch a new one. Let's do exactly that.

## Configuring your conda with channels
Now we install some useful channels (searchable repositories, essentially) for Miniconda

```
conda config --add channels r
conda config --add channels defaults
conda config --add channels conda-forge
conda config --add channels bioconda
```

## Using conda to search for bioinformatics tools

Searching for packages by (exact) name

Let's try searching for Lior Pachter's kallisto RNA-seq tool, and the slightly more traditional bowtie-2 alignment tool

```
conda search kallisto
conda search samtools
conda search bowtie-2
```

So, kallisto is found, but bowtie-2 is not. Let's use google to see if there might be a sleuth package but with a different name than the one we searched for. Google `conda bowtie-2`

It looks like the correct package name is `bowtie2`. Let's try:

`conda search bowtie2`

## Installing named packages:

You have choices. There are two ways to install things with conda.
1. Directly e.g. `conda install kallisto`
2. Toggle-able Environments

Option 1 is much simpler. It installs it without an environmentm into your base installation. But this can get you into trouble in the long run. If you need to change versions of an installed software, it will be at least a bit more more work to remove the existing one and replace it with the different version `conda remove [tool]`. In worse scenarios, if you have incompatible software, they will conflict unless encapsulated within environments.

Installing to an environment, and activating the environment take these two forms:

```
conda create -n [my_cool_env] [tool1] [tool2] ... [toolN]
source activate [my_cool_env]
```
Using environments is smarter in the long run. It comes with cognitive costs, though. You have to remember your environment name (or look for it) and activate your desired environment after logging in.

Let's install bowtie2 and samtools into an environment.

`conda create -n align_env bowtie2 samtools`

You can activate the `align_env` to use these versions

`source activate align_env` (and now verify that they're installed using `which` and test run them too)

And deactivate the env thusly

`source deactivate`

### Installing a specific version of a package in a new environment

To create a specifc environment for Stacks, version 1.47, this command looks like:

```
conda create -n stacks147_env stacks=1.47
```



## What did I install last week/month/year?

First, take a look at the usage and syntax for `conda info`, by using

`conda info --help` (the --help option can be used for all conda verbs)

If you forget the names of some of your Environments

`conda info -e`

to see what is a part of that Environment

`conda list -n my_cool_env`

to see what is installed in base

`conda list -n base` (base is an environment too)

To check the overall configuration of your conda installation

`conda info`


## Adding more tools to an existing environment

To install new things (here, FastQC) to an environment you previously made

First, search for FastQC (google for the capitalization or not, then)

`conda search fastqc`

Then,

`conda install -n align_env fastqc`

Verify by activating the environment, `which`, and testing the help messages of fastqc

### Updating conda
`conda update conda`

### Updating installed packages
Updating something installed to base
`conda update bowtie2`

Updating a tool that is in an environment
`conda update -n kallisto_env bowtie2`

## Toggling Environments

(if in an environment)
```
source deactivate
source activate align_env
```

## Removing packages
Removing packages in an environment

`conda remove -n align_env samtools`

Removing entire environments

`conda remove -n align_env --all`

Removing something installed to base (the lazy way)

`conda remove -n kallisto`

## Turning the entire conda system off

1. open (edit) your `~/.bashrc` file using `nano`
2. scroll all the way down until you see lines related to Miniconda
3. comment those out with the `#` symbol at the start of the line
4. log out and log back in (this is more safe than just using `source ~/.bashrc` with conda)
