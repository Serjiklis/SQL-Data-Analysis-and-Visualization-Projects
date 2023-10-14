
-- CLEANING DATA IN SQL QUERIES

SELECT *
FROM PortfolioProject.NashvilleHousing;

-- STANDARTIZE DATA FORMAT

UPDATE PortfolioProject.NashvilleHousing
SET SaleDate = STR_TO_DATE(SaleDate, '%M %e, %Y');

ALTER TABLE PortfolioProject.NashvilleHousing
    MODIFY COLUMN SaleDate DATE;


-- POPULATE PROPERTY ADDRESS DATA

-- Replace empty values with NULL
UPDATE PortfolioProject.NashvilleHousing
SET
    PropertyAddress = CASE WHEN PropertyAddress = '' THEN NULL ELSE PropertyAddress END;

-- Visual check of changes made to the table.
SELECT *
FROM PortfolioProject.NashvilleHousing
     WHERE PropertyAddress IS NULL
ORDER BY ParcelID;

-- Retrieve PropertyAddress values from a self-join of NashvilleHousing where PropertyAddress is null in 'a' and fallback to 'b'
SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, IFNULL(a.PropertyAddress, b.PropertyAddress)
FROM PortfolioProject.NashvilleHousing a
         JOIN PortfolioProject.NashvilleHousing b
              ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
WHERE a.PropertyAddress IS NULL;

UPDATE PortfolioProject.NashvilleHousing a
    JOIN PortfolioProject.NashvilleHousing b
    ON a.ParcelID = b.ParcelID AND a.UniqueID <> b.UniqueID
SET a.PropertyAddress = IFNULL(a.PropertyAddress, b.PropertyAddress)
WHERE a.PropertyAddress IS NULL;


-- BREAKING OUT ADDRESS INTO INDIVIDUAL COLUMNS (Address, City, State)

Select PropertyAddress
From PortfolioProject.NashvilleHousing;


/*
Simple query
SELECT
    SUBSTRING_INDEX(PropertyAddress, ',', 1) AS PropertySplitAddress,
    SUBSTRING_INDEX(PropertyAddress, ',', -1) AS PropertySplitCity
FROM PortfolioProject.NashvilleHousing;
*/


SELECT
    SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1) as Address,
    SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, CHAR_LENGTH(PropertyAddress)) as Address
FROM PortfolioProject.NashvilleHousing;


-- ADD COLUMN PropertySplitAddress

-- Add Property Split Address Column: Adds a new column 'PropertySplitAddress'.

ALTER TABLE PortfolioProject.NashvilleHousing
    Add PropertySplitAddress VARCHAR(255);

-- Update Property Split Address: Populates the 'PropertySplitAddress' column with the part of 'PropertyAddress' before the comma (',').
Update PortfolioProject.NashvilleHousing
SET PropertySplitAddress =  SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);

-- Add Property Split City Column: Adds a new column 'PropertySplitCity'

ALTER TABLE PortfolioProject.NashvilleHousing
    Add PropertySplitCity VARCHAR(255);

-- Update Property Split City: Populates the 'PropertySplitCity' column with the part of 'PropertyAddress' after the comma (',').

Update PortfolioProject.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, CHAR_LENGTH(PropertyAddress));

-- Visual check of changes made to the table NashvilleHousing.

Select PropertyAddress,PropertySplitCity, PropertySplitAddress
From PortfolioProject.NashvilleHousing;


-- Owner Adress

-- Update Owner Address: Set empty 'OwnerAddress' values to NULL.

UPDATE PortfolioProject.NashvilleHousing
SET
    OwnerAddress = CASE WHEN OwnerAddress = '' THEN NULL ELSE OwnerAddress END;
-- Select Null Owner Addresses: Retrieve records where 'OwnerAddress' is NULL.

SELECT OwnerAddress
FROM PortfolioProject.NashvilleHousing
WHERE OwnerAddress IS NULL ;

-- Split Owner Address: Extract and split 'OwnerAddress' into three parts, Part1, Part2, and Part3.

SELECT OwnerAddress,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -3), '.', 1) AS Part1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -2), '.', 1) AS Part2,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -1), '.', 1) AS Part3
FROM PortfolioProject.NashvilleHousing;

-- Add Owner Split Address Column: Add a new column 'OwnerSplitAddress' to the table.

ALTER TABLE PortfolioProject.NashvilleHousing
    ADD OwnerSplitAddress VARCHAR(255);
-- Update Owner Split Address: Populate 'OwnerSplitAddress' with the first part of the split 'OwnerAddress'.

UPDATE PortfolioProject.NashvilleHousing
SET OwnerSplitAddress =SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -3), '.', 1);

-- Add Owner Split City Column: Add a new column 'OwnerSplitCity' to the table.

ALTER TABLE PortfolioProject.NashvilleHousing
    ADD OwnerSplitCity VARCHAR(255);

-- Update Owner Split City: Populate 'OwnerSplitCity' with the second part of the split 'OwnerAddress'.

UPDATE PortfolioProject.NashvilleHousing
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -2), '.', 1);

-- Add Owner Split State Column: Add a new column 'OwnerSplitState' to the table.

ALTER TABLE PortfolioProject.NashvilleHousing
    ADD OwnerSplitState VARCHAR(255);

-- Update Owner Split State: Populate 'OwnerSplitState' with the third part of the split 'OwnerAddress'.

UPDATE PortfolioProject.NashvilleHousing
SET OwnerSplitState = SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -1), '.', 1);


-- Change Y and N to Yes and No in "Sold as Vacant" field

-- Count occurrences of distinct values in 'SoldAsVacant' and sort by count.
SELECT DISTINCT (SoldAsVacant), Count(SoldAsVacant)
FROM PortfolioProject.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2;


/*
This code checks a condition before making changes in the database and selects the "SoldAsVacant" column,
replacing 'Y' with 'Yes', 'N' with 'No', and keeping the original value for any other cases in the NashvilleHousing table
of the PortfolioProject database.
 */

SELECT SoldAsVacant
     , CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
            WHEN SoldAsVacant = 'N' THEN 'No'
            ELSE SoldAsVacant
    END
FROM PortfolioProject.NashvilleHousing;

/*
This is a SQL query that updates a column called 'SoldAsVacant' in a database table called 'NashvilleHousing'.
The query uses a CASE statement to set the value of 'SoldAsVacant' to 'Yes' or 'No' depending on its current value.
 */

UPDATE PortfolioProject.NashvilleHousing
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
                        WHEN SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                       END

-- REMOVE DUPLICATES

-- Search for duplicates

 WITH RowNumCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
            PropertySplitAddress,
            SalePrice,
            LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM PortfolioProject.NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY ParcelID;

-- Removing duplicates

DELETE FROM PortfolioProject.NashvilleHousing
WHERE (ParcelID, PropertySplitAddress, SalePrice, LegalReference, UniqueID) IN (
    SELECT ParcelID, PropertySplitAddress, SalePrice, LegalReference, UniqueID
    FROM (
             SELECT *,
                    ROW_NUMBER() OVER (
                        PARTITION BY ParcelID, PropertySplitAddress, SalePrice, LegalReference
                        ORDER BY UniqueID
                        ) AS row_num
             FROM PortfolioProject.NashvilleHousing
         ) AS RowNumCTE
    WHERE row_num > 1
);


-- DELETE UNUSED COLUMNS

SELECT *
FROM PortfolioProject.NashvilleHousing;


ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN OwnerAddress;

ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN TaxDistrict;

ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN PropertyAddress;

ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN SaleDate;

















