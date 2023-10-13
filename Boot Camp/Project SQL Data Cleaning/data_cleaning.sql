/*

Cleaning Data in SQL Queries

*/


Select *
From PortfolioProject.NashvilleHousing;

-- --------------------------------------------------------------------------------------------------------------------------

-- Standardize Date Format

UPDATE PortfolioProject.NashvilleHousing
SET SaleDate = STR_TO_DATE(SaleDate, '%M %e, %Y');

ALTER TABLE PortfolioProject.NashvilleHousing
    MODIFY COLUMN SaleDate DATE;


-- Populate Property Address data

-- Replace empty values with NULL
UPDATE PortfolioProject.NashvilleHousing
SET
    PropertyAddress = CASE WHEN PropertyAddress = '' THEN NULL ELSE PropertyAddress END;

Select *
From PortfolioProject.NashvilleHousing
     Where PropertyAddress is null
order by ParcelID;

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


-- Breaking out Address into Individual Columns (Address, City, State)

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


-- Add column PropertySplitAddress
ALTER TABLE PortfolioProject.NashvilleHousing
    Add PropertySplitAddress VARCHAR(255);

Update PortfolioProject.NashvilleHousing
SET PropertySplitAddress =  SUBSTRING(PropertyAddress, 1, LOCATE(',', PropertyAddress) - 1);


ALTER TABLE PortfolioProject.NashvilleHousing
    Add PropertySplitCity VARCHAR(255);

Update PortfolioProject.NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, LOCATE(',', PropertyAddress) + 1, CHAR_LENGTH(PropertyAddress));


Select PropertyAddress,PropertySplitCity, PropertySplitAddress
From PortfolioProject.NashvilleHousing;


-- Owner Adress
UPDATE PortfolioProject.NashvilleHousing
SET
    OwnerAddress = CASE WHEN OwnerAddress = '' THEN NULL ELSE OwnerAddress END;

Select OwnerAddress
From PortfolioProject.NashvilleHousing
WHERE OwnerAddress is null;


SELECT OwnerAddress,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -3), '.', 1) AS Part1,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -2), '.', 1) AS Part2,
    SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -1), '.', 1) AS Part3
FROM PortfolioProject.NashvilleHousing;




ALTER TABLE PortfolioProject.NashvilleHousing
    Add OwnerSplitAddress VARCHAR(255);

Update PortfolioProject.NashvilleHousing
SET OwnerSplitAddress =SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -3), '.', 1);


ALTER TABLE PortfolioProject.NashvilleHousing
    Add OwnerSplitCity VARCHAR(255);

Update PortfolioProject.NashvilleHousing
SET OwnerSplitCity = SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -2), '.', 1);



ALTER TABLE PortfolioProject.NashvilleHousing
    Add OwnerSplitState VARCHAR(255);

Update PortfolioProject.NashvilleHousing
SET OwnerSplitState = SUBSTRING_INDEX(SUBSTRING_INDEX(REPLACE(OwnerAddress, ',', '.'), '.', -1), '.', 1);



Select *
From PortfolioProject.NashvilleHousing;




# --------------------------------------------------------------------------------------------------------------------------


-- Change Y and N to Yes and No in "Sold as Vacant" field


Select Distinct(SoldAsVacant), Count(SoldAsVacant)
From PortfolioProject.NashvilleHousing
Group by SoldAsVacant
order by 2;




Select SoldAsVacant
     , CASE When SoldAsVacant = 'Y' THEN 'Yes'
            When SoldAsVacant = 'N' THEN 'No'
            ELSE SoldAsVacant
    END
From PortfolioProject.NashvilleHousing;


Update PortfolioProject.NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
                        When SoldAsVacant = 'N' THEN 'No'
                        ELSE SoldAsVacant
                       END

#     -----------------------------------------------------------------------------------------------------------------------------------------------------

-- Remove Duplicates

 WITH RowNumCTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY ParcelID,
            PropertyAddress,
            SalePrice,
            SaleDate,
            LegalReference
            ORDER BY UniqueID
        ) AS row_num
    FROM PortfolioProject.NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num > 1
ORDER BY PropertyAddress;


Select *
From PortfolioProject.NashvilleHousing;


#  ---------------------------------------------------------------------------------------------------------

-- Delete Unused Columns

Select *
From PortfolioProject.NashvilleHousing;


ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN OwnerAddress;

ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN TaxDistrict;

ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN PropertyAddress;

ALTER TABLE PortfolioProject.NashvilleHousing
    DROP COLUMN SaleDate;

















